Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTFKVQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 17:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFKVQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 17:16:22 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:22746 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S264476AbTFKVO6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 17:14:58 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 14:23:30 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 13:10, Bryan O'Sullivan wrote:


+		if (offset > tick_usec) {
+			lost = offset / tick_usec;
+			offset %= tick_usec;
+		}

Hmmm. Thats likely part to blame for the lost-ticks code not working. I
believe tick_usec is calculated USER_HZ rather then HZ, so you'll be off
by an order of magnitude. I ran into the exact same problem. 

thanks
-john



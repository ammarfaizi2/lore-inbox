Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261769AbTKRAgW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 19:36:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTKRAgW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 19:36:22 -0500
Received: from zok.SGI.COM ([204.94.215.101]:44765 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261769AbTKRAgV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 19:36:21 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Joe Korty <joe.korty@ccur.com>, "Luck, Tony" <tony.luck@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: format_cpumask() 
In-reply-to: Your message of "Mon, 17 Nov 2003 16:26:47 -0800."
             <20031118002647.GH22764@holomorphy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Nov 2003 11:34:11 +1100
Message-ID: <2173.1069115651@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 16:26:47 -0800, 
William Lee Irwin III <wli@holomorphy.com> wrote:
>+		m = sprintf(buf, "%0*lx", 2*sizeof(long), cpus_coerce(tmp));

Sorry, that has to be 

+		m = sprintf(buf, "%0*lx", (int)(2*sizeof(long)), cpus_coerce(tmp));

otherwise gcc complains on 64 bit systems.  The '*' flag requires an
int parameter, sizeof returns long.


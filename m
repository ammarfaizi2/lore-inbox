Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263577AbUECCsC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUECCsC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUECCqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:46:21 -0400
Received: from holomorphy.com ([207.189.100.168]:21892 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263567AbUECCqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:46:08 -0400
Date: Sun, 2 May 2004 19:46:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [0/2] filtered wakeups
Message-ID: <20040503024606.GJ1397@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040503021709.GF1397@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040503021709.GF1397@holomorphy.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 07:17:09PM -0700, William Lee Irwin III wrote:
> before:
> Tiotest results for 512 concurrent io threads:

Parting shot: I also used time(1):

before:
tiotest -t 512 -f 32 -b 4096 -d .  14337.17s user 3931.52s system 301% cpu 1:40:51.08 total

after:
tiotest -t 512 -f 32 -b 4096 -d .  10985.23s user 3524.50s system 266% cpu 1:30:48.80 total

i.e. it sped up the run by 10 minutes, or 10% of the total execution time.


-- wli

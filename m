Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTLSIJr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 03:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLSIJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 03:09:46 -0500
Received: from holomorphy.com ([199.26.172.102]:12694 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262041AbTLSIJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 03:09:46 -0500
Date: Fri, 19 Dec 2003 00:09:40 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Yun Zhou <sraphim@mofd.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HD access sluggish in 2.6.0
Message-ID: <20031219080940.GG31393@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Yun Zhou <sraphim@mofd.net>, linux-kernel@vger.kernel.org
References: <200312181957.05917.sraphim@mofd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312181957.05917.sraphim@mofd.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 07:57:05PM -0600, Yun Zhou wrote:
> I'm using a system with 1HD (DC WD600BB-00CAA1 60 GB) using kernel 2.6.0. 
> Whenever the system uses the disk extensively (copying a file, untarring, 
> etc.), it grinds to a near halt, with the CPU usage at about 100%, even for a 
> simple copying operation.
> This problem is not present when using 2.4.22, nor any of the 2.4 series 
> kernels that I've tried. Does anyone know what is causing this?
> Thanks in advance!

This is typical of IDE disks where the driver is pessimistically using
PIO. A dmesg and .config would help, plus maybe readprofile(1) results
(you'll have to boot with profile=1 on the kernel command-line.) just
in case it's actually something else.


-- wli

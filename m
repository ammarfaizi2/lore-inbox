Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262923AbVAKWo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbVAKWo6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 17:44:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbVAKWn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 17:43:28 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:38634 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262923AbVAKWmo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 17:42:44 -0500
Date: Tue, 11 Jan 2005 14:41:30 -0800
From: Greg KH <greg@kroah.com>
To: Jonas Munsin <jmunsin@iki.fi>, Jean Delvare <khali@linux-fr.org>,
       pioppo@ferrara.linux.it, sensors@Stimpy.netroedge.com, djg@pdp8.net,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-mm2: it87 sensor driver stops CPU fan
Message-ID: <20050111224130.GA19173@kroah.com>
References: <200501102341.44949.pioppo@ferrara.linux.it> <YN0o4rkI.1105435582.0805630.khali@localhost> <20050111202437.GA2914@nemo.sby.abo.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050111202437.GA2914@nemo.sby.abo.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2005 at 10:24:38PM +0200, Jonas Munsin wrote:
> On Tue, Jan 11, 2005 at 10:26:22AM +0100, Jean Delvare wrote:
> > 1* Jonas, please send a modified version of your original patch to Greg.
> > The only difference would be that you wouldn't force on/off mode to be
> > on at driver load time. Instead, disabling PWM for one fan control
> > output (echo 0 > pwmN_enable) would both set on/off mode to on for that
> > output (new) and turn that output to on/off mode (same as before).
> 
> Ok, thanks for doing the thinking ;), here is the modified patch
> (it87.c_2.6.10-jm3-corrected_manual_pwm_20050111.diff). In addition to
> the above change, it also refreshes fan_main_ctrl in the update routine,
> as suggested by Jean on IRC.
> 
>  - adds manual PWM
>  - removes buggy "reset" module parameter
>  - fixes some whitespaces

Applied, thanks.

greg k-h

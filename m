Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262657AbUCERGk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262660AbUCERGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:06:40 -0500
Received: from holomorphy.com ([207.189.100.168]:57100 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262657AbUCERGj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:06:39 -0500
Date: Fri, 5 Mar 2004 09:06:19 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: initrd does not boot in 2.6.3, working in 2.4.25
Message-ID: <20040305170619.GX655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <200403051238.53470.vda@port.imtp.ilyichevsk.odessa.ua> <20040305110451.GR655@holomorphy.com> <200403051831.31271.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403051831.31271.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 13:04, William Lee Irwin III wrote:
>> nfsroot works in 2.6.3 and above here. I'm not sure you need it per se
>> for initrd's; I think the way it's intended to work with that is for
>> the scripts to configure network interfaces, mount the nfsroot, and then
>> pivot_root(). Can you try without initrd?
>> Also, try passing ip= for these things.

On Fri, Mar 05, 2004 at 06:31:31PM +0200, Denis Vlasenko wrote:
> I run these things everyday.
> nfsroot and ip=.... works, no question about that.
> Just imagine all-modular kernel which needs to load ethernet driver first,
> *then* mount nfs root and pivot_root. Or nfsroot-over-wireless :)
> --
> vda

For this, you should probably script the initrd to do the IP
configuration and mount the nfsroot before pivot_root().


-- wli

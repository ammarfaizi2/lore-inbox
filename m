Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVA2TaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVA2TaT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 14:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVA2T00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 14:26:26 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:22592 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261566AbVA2TZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 14:25:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=ARJlIKdn2pYhold2SZce0gAhclg8SPXONuRmnapcu7cYANwtRORwgVq5AoHnYvtTb05zwEVExqd131axRtrymL3xtnEuW4nb1eTcqFBIswzSv7wwFRFcBVdY0V/SFV3YaNY5zbBjbyKwyj9vytATwp5DIE3Ei6EYLoc31icjDG4=
Message-ID: <9e473391050129112525f4947@mail.gmail.com>
Date: Sat, 29 Jan 2005 14:25:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: ee21rh@surrey.ac.uk
Subject: Re: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
	 <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
	 <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
	 <pan.2005.01.29.13.02.51.478976@surrey.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005 13:02:51 +0000, Richard Hughes <ee21rh@surrey.ac.uk> wrote:
> On Sat, 29 Jan 2005 12:49:16 +0000, Richard Hughes wrote:
> > Note, that strace glxgears gives exactly the same output, going from 0 to
> > 14 and then seg-faulting, so it's *not just a oo problem*.
> 
> I know it's bad to answer your own post, but here goes.
> 
> I changed my /etc/udev/permissions.d/50-udev.permissions config to read:
> 
> dri/*:root:root:0666
> 
> changing it from
> 
> dri/*:root:root:0660
> 
> And oowriter and glxgears work from bootup. Shall I file a bug with udev?

Your user ID needs to belong to group DRI.

-- 
Jon Smirl
jonsmirl@gmail.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbTF3H5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264927AbTF3H5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:57:43 -0400
Received: from vtens.prov-liege.be ([193.190.122.60]:33119 "EHLO
	mesepl.epl.prov-liege.be") by vger.kernel.org with ESMTP
	id S264828AbTF3H5H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:57:07 -0400
Message-ID: <D9B4591FDBACD411B01E00508BB33C1B01405371@mesadm.epl.prov-liege.be>
From: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
To: "'viro@parcelfarce.linux.theplanet.co.uk'" 
	<viro@parcelfarce.linux.theplanet.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Trying to improve /proc/filesystems
Date: Mon, 30 Jun 2003 09:55:45 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander,

	Why don't we have centralized /proc/filesystems access ? 2 fields
file for fs can't be a standard
Take a look at slab outputs evolution for instance....

Regards,
Fabian

-----Message d'origine-----
De : viro@parcelfarce.linux.theplanet.co.uk
[mailto:viro@parcelfarce.linux.theplanet.co.uk]
Envoyé : lundi 30 juin 2003 09:53
À : Frederick, Fabian
Cc : 'linux-kernel@vger.kernel.org'
Objet : Re: [PATCH] Trying to improve /proc/filesystems


On Mon, Jun 30, 2003 at 09:21:00AM +0200, Frederick, Fabian wrote:
> Hi,
> 	I'm trying to do 
> 
> nodev		xxx	0
> 		yyy	2
> (or replace nodev by 0->x)
> 
> with the following but Linux complains : VFS : unable to mount
> root....Someone could help ?

Yes.  Layout of files in procfs should be treated as a part of ABI.
IOW, you make incompatible change - things break.

Folks, file in /proc is not different from a syscall in that respect -
changing layout has the same effect as changes of layout in syscall
arguments.

IOW, don't do that.

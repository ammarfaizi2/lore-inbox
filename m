Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbULZT4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbULZT4y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 14:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbULZT4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 14:56:54 -0500
Received: from mail1.kontent.de ([81.88.34.36]:60828 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S261151AbULZT4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 14:56:53 -0500
From: Oliver Neukum <oliver@neukum.org>
To: William Park <opengeometry@yahoo.ca>
Subject: Re: usb-storage loads scsi_mod, but not sd_mod (2.6.9)
Date: Sun, 26 Dec 2004 20:55:07 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20041226191918.GA5166@node1.opengeometry.net>
In-Reply-To: <20041226191918.GA5166@node1.opengeometry.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200412262055.07877.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 26. Dezember 2004 20:19 schrieb William Park:
> Dear USB developers,
> 
> In 2.6.9, 'usb-storage' module depends on 'scsi_mod', but not 'sd_mod'.
> This means that I have to load 'sd_mod' manually, or put something like
>     alias block-major-8-* sd_mod
> in /etc/modprobe.conf.
> 
> Is there reason why 'sd_mod' is not listed as one of dependant modules
> for 'usb-storage'?

Yes. You might connect optical and tape drives as well as even other SCSI
devices by bridges. We must not assume all storage devices to use sd.

	Regards
		Oliver

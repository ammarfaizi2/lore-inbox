Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWECP6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWECP6j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 11:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030231AbWECP6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 11:58:39 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:17234 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1030230AbWECP6i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 11:58:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VOmXt9hQId4GjElwSdx4Ufa+pPiT8z4AzNbcXlcoGU287dT2j0lvorKCnONBaavl6DdZEJsvuDWY+CwH/IoZxhC7CTje/ICzi7grJreVTa12Zcu7XfMnPcURPKMHnGz0AvJWSqCRqF/feqJvLOIFDwNsWKjlgaHaNLyS+PNAMQU=
Message-ID: <6934efce0605030858k3967489p55ef98a26e71b761@mail.gmail.com>
Date: Wed, 3 May 2006 08:58:36 -0700
From: "Jared Hulbert" <jaredeh@gmail.com>
To: "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>
Subject: Re: [RFC] Advanced XIP File System
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060503154700.GD5250@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <6934efce0605021453l31a438c4j7c429e6973ab4546@mail.gmail.com>
	 <20060503130502.GD19537@wohnheim.fh-wedel.de>
	 <6934efce0605030831h30d7e4e3hb057fd1b3f7791d3@mail.gmail.com>
	 <20060503154700.GD5250@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Correct.  It is not a must-fix, but having seperate workspaces for all
> the filesystems seems wasteful.

Agreed.  So we copy the cramfs uncompress routines line for line. 
That optimization seems like low hanging fruit.

To consolidate them how should that be approached?  Create
fs/uncompress.c?  Modify axfs and cramfs to use it?

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262782AbSJ1AMQ>; Sun, 27 Oct 2002 19:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSJ1AMQ>; Sun, 27 Oct 2002 19:12:16 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:29971 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262782AbSJ1AMP>; Sun, 27 Oct 2002 19:12:15 -0500
Date: Mon, 28 Oct 2002 00:18:31 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kenneth Johansson <ken@kenjo.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andreas Haumer <andreas@xss.co.at>,
       linux-kernel@vger.kernel.org, willy@w.ods.org
Subject: Re: rootfs exposure in /proc/mounts
Message-ID: <20021028001831.A31614@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kenneth Johansson <ken@kenjo.org>, Jeff Garzik <jgarzik@pobox.com>,
	Andreas Haumer <andreas@xss.co.at>, linux-kernel@vger.kernel.org,
	willy@w.ods.org
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu> <3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com> <3DBBBE1B.5050809@xss.co.at> <3DBC0007.8020005@pobox.com> <20021027150936.A20310@infradead.org> <1035763409.4176.5.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035763409.4176.5.camel@tiger>; from ken@kenjo.org on Mon, Oct 28, 2002 at 01:03:28AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 01:03:28AM +0100, Kenneth Johansson wrote:
> On Sun, 2002-10-27 at 16:09, Christoph Hellwig wrote:
> > you might have very different mounts in different processes.
> 
> You can ?? apart from chroot that can make things interesting  how do
> you do this?

clone(..., CLONE_NEWNS, ...)

After that subsequent namespace operations will only affect your process
and it's child processes.

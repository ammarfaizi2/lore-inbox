Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291297AbSBZQzv>; Tue, 26 Feb 2002 11:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291269AbSBZQzn>; Tue, 26 Feb 2002 11:55:43 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20748 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291193AbSBZQz3>; Tue, 26 Feb 2002 11:55:29 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ext3 and undeletion
Date: 26 Feb 2002 08:55:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a5gell$432$1@cesium.transmeta.com>
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <20020226160544.GD4393@matchmail.com> <3C7BB86A.7090305@zytor.com> <20020226164036.GG4393@matchmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020226164036.GG4393@matchmail.com>
By author:    Mike Fedyk <mfedyk@matchmail.com>
In newsgroup: linux.dev.kernel
> 
> Uhh, no.
> 
> You have a configurable size for the undelete dirs and you delete a file.
> Now, that file gets moved to $mountpoint/.undelete.  The daemon gets
> notified through a socket, and it can check to see if it needs to delete any
> older deleted files to make sure .undelete doesn't get bigger than
> configured.  
> 
> We're only scanning the dirs upon daemon startup (reminds me of
> quota... ;), and all other daemon actions are triggered by unlink() writing
> to a socket.  The worst thing that can happen is not seeing your free space
> immediately, but a few seconds later.
> 

Hence race condition.  Also, the solution to hard-reserve space seems
to fundamentally defeat the purpose (IMO).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>

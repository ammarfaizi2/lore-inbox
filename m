Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315226AbSDWPAc>; Tue, 23 Apr 2002 11:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315228AbSDWPAb>; Tue, 23 Apr 2002 11:00:31 -0400
Received: from AMontpellier-201-1-4-206.abo.wanadoo.fr ([217.128.205.206]:5564
	"EHLO awak") by vger.kernel.org with ESMTP id <S315226AbSDWPAa> convert rfc822-to-8bit;
	Tue, 23 Apr 2002 11:00:30 -0400
Subject: Re: Adding snapshot capability to Linux
From: Xavier Bestel <xavier.bestel@free.fr>
To: Alexander Viro <viro@math.psu.edu>
Cc: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0204231041010.8087-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 23 Apr 2002 16:58:50 +0200
Message-Id: <1019573931.11011.0.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mar 23-04-2002 à 16:45, Alexander Viro a écrit :
> You _can't_ get consistent snapshots without cooperation from fs.  LVM,
> EVMS, whatever.  Only filesystem knows what IO needs to be pushed to
> make what we have on device consistent and what IO needs to be held
> back.  Neither VFS nor device driver do not and can not have such
> knowledge - it depends both on fs layout and on implementation details.

I always thought that with a journalled fs, data was always consistent
on disk - i.e. always in a state where remounting the image (and
replaying the journal) makes it consistent.



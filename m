Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422644AbWBAPtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422644AbWBAPtw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 10:49:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWBAPtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 10:49:52 -0500
Received: from uproxy.gmail.com ([66.249.92.197]:34389 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1422642AbWBAPtv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 10:49:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eaH/gLa4jjC6IGsV9JITM6FxP46SAwK1I3eZ2NimesRDHbu4asImNznRzVw/CR+uSlAPhJACr7Hydf1/3nAeO3VRUYFDbenpUeO/qwrTA/zFnZ7/ZrizXUcdPc6tSgc03/VkZG3IA+1dfspBo5QO85/W/fnKvNVtfMyhl0W1A9M=
Message-ID: <58cb370e0602010749r7ab0273x8fad3d5a76d67b76@mail.gmail.com>
Date: Wed, 1 Feb 2006 16:49:48 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, mrmacman_g4@mac.com,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       James@superbug.co.uk, j@bitron.ch, acahalan@gmail.com
In-Reply-To: <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
	 <43DF678E.nail3B431CUWJ@burner>
	 <58cb370e0601310623ic220d27q3bfd4642cd0538fb@mail.gmail.com>
	 <Pine.LNX.4.61.0602011630440.22529@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >>
> >> This is called integration and it is done by Linux e.g. for 1394 and USB SCSI
> >> devices. So why not for ATAPI?
> >
> >Because we have native drivers which do not require SCSI stack et all.
> >
> >* if [ED: it] is very useful if cd-writing can be done with ide-cd and without
> >  SCSI stack (a hack but very useful one)
> >* you don't need SCSI stack (a lot of code saved!)
>
>
> Which unfortunately leads us back to one of the early questions.
>
> If ATAPI is some sort of SCSI [command set] over ATA, and ide-cd can be used
> without the "Big Bad" SCSI layer (CONFIG_SCSI), don't we have redundant code
> floating around?

No, because this code belongs to the block layer (scsi_ioctl.c)
and is shared between SCSI and IDE drivers.

BTW This was already at least once explained in this thread.

Bartlomiej

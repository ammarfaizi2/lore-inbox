Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161268AbWHDS57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161268AbWHDS57 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161257AbWHDS57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:57:59 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:42836 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161268AbWHDS56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:57:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fCEuII6KX2fC8IPXOjuAnWQWASg667VYaoBHpvwPec3njKIGmCme4GWhDYhYwgZGsJX/UkdwOFERYulP5RJWcdxF61TC+IMEkAqsdQsQbAGYyfxu1hSRd7LNvq3gVeVHBho3rO1JpCeR2/loVPGHn9yuf594X3Ig/1VJSuC2tdA=
Message-ID: <69304d110608041157p125e5c8oef58b02f6c81fa29@mail.gmail.com>
Date: Fri, 4 Aug 2006 20:57:46 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Edward Shishkin" <edward@namesys.com>
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Cc: "Hans Reiser" <reiser@namesys.com>,
       "Matthias Andree" <matthias.andree@gmx.de>, ric@emc.com,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Adrian Ulrich" <reiser4@blinkenlights.ch>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>, bernd-schubert@gmx.de,
       reiserfs-list@namesys.com, jbglaw@lug-owl.de, clay.barnes@gmail.com,
       rudy@edsons.demon.nl, ipso@snappymail.ca, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org
In-Reply-To: <44D37E1B.1040109@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607312314.37863.bernd-schubert@gmx.de>
	 <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl>
	 <20060801165234.9448cb6f.reiser4@blinkenlights.ch>
	 <1154446189.15540.43.camel@localhost.localdomain>
	 <44CF9BAD.5020003@emc.com> <44CF3DE0.3010501@namesys.com>
	 <20060803140344.GC7431@merlin.emma.line.org>
	 <44D219F9.9080404@namesys.com> <44D231DF.1080804@namesys.com>
	 <44D37E1B.1040109@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/06, Edward Shishkin <edward@namesys.com> wrote:
> Hans Reiser wrote:
> > Edward Shishkin wrote:
> >
> >
> >>Matthias Andree wrote:
> >>
> >>
> >>>On Tue, 01 Aug 2006, Hans Reiser wrote:
> >>>
> >>>
> >>>
> >>>>You will want to try our compression plugin, it has an ecc for every
> >>>>64k....
> >>>
> >>>
> >>>
> >>>What kind of forward error correction would that be,
> >>
> >>
> >>
> >>Actually we use checksums, not ECC. If checksum is wrong, then run
> >>fsck - it will remove the whole disk cluster, that represent 64K of
> >>data.
> >
> >
> > How about we switch to ecc, which would help with bit rot not sector loss?
>
> Interesting aspect.
>
> Yes, we can implement ECC as a special crypto transform that inflates
> data. As I mentioned earlier, it is possible via translation of key
> offsets with scale factor > 1.
>
> Of course, it is better then nothing, but anyway meta-data remains
> ecc-unprotected, and, hence, robustness is not increased..
>
> Edward.
>
> >
> >>
> >> and how much and
> >>
> >>
> >>>what failure patterns can it correct? URL suffices.
> >>>
> >>
> >>Checksum is checked before unsafe decompression (when trying to
> >>decompress incorrect data can lead to fatal things). It can be
> >>broken because of many reasons. The main one is tree corruption
> >>(for example, when disk cluster became incomplete - ECC can not
> >>help here). Perhaps such checksumming is also useful for other
> >>things, I didnt classify the patterns..
> >>
> >>Edward.
> >>
> >>

Would the storage + plugin subsystem support storing >1 copies of the
metadata tree?


-- 
Greetz, Antonio Vargas aka winden of network

http://network.amigascne.org/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.

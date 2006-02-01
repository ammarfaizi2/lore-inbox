Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWBAFHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWBAFHN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Feb 2006 00:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWBAFHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Feb 2006 00:07:13 -0500
Received: from zproxy.gmail.com ([64.233.162.198]:63653 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030302AbWBAFHL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Feb 2006 00:07:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UXQx9lBm7p/mD7Y7VNr/0M3U6VS9qYKM3fUEmP6CfdJHJt4vJUgGgwj30ZwRWU1bxzIPb4ZUiv56z/I0TViKCAhIvuBp5DkOlRiQuG0Ktn+t8esLrJacHBzIDzcPGSzyiLxVbmcqEoJwGEdHNwXTR5mYd2zwGQev3q6w0o+KbfA=
Message-ID: <787b0d920601312107k31542295vb0bdee4bb2a67a39@mail.gmail.com>
Date: Wed, 1 Feb 2006 00:07:10 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: paul@hibernia.jakma.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, j@bitron.ch,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk
In-Reply-To: <Pine.LNX.4.64.0601311639140.3920@sheen.jakma.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
	 <Pine.LNX.4.64.0601311639140.3920@sheen.jakma.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Paul Jakma <paul@clubi.ie> wrote:
> On Tue, 31 Jan 2006, Joerg Schilling wrote:
>
> > What Linux does is to artificially prevent this view to been seen
> > from outside the Linux kernel, or to avoid integrating a particular
> > device into a unique SCSI driver system although it would be
> > apropriate.
>
> So let's get this straight: Linux is artificially limiting userspace
> from viewing devices in terms of parallel SCSI address (B/T/L)
> because it does not create such B/T/L addresses, ones which would
> hence be *artificial* themselves, for non-parallel-SCSI devices?

There is a slim chance that Joerg might really believe that
Linux has an internal B/T/L view of everything. That would
be odd to us of course. He has clearly been spending time
with the Solaris kernel. If his only kernel experience comes
from systems that do make up a phony B/T/L view, then he might
just assume that all operating systems are designed this way.

For Joerg's reference, open() goes like this:

1. the /dev name
2. the inode
3. the device number
4. pointers to structs full of function pointers

Nowhere is it in B/T/L form.

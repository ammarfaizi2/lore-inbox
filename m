Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWHGPTx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWHGPTx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWHGPTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:19:53 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:28933 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932148AbWHGPTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:19:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NIAxeOnBcIBs3Fn7GQDAGj5SPySiyAwXT13z6qj5bMHYZLJa55HbXqzhut/QXOZYJSjC0LE76MwkRxkR1lhOAVru0RgzoAyyVlfc1ejDH64D1XBDWtG85Ec75FrJLxgeOsrao5suOn4p69lUfa4g429Kx0VFxbQy92q8Hm/dGfs=
Message-ID: <787b0d920608070819u5f93b7c5pb45b323d4c74bde4@mail.gmail.com>
Date: Mon, 7 Aug 2006 11:19:47 -0400
From: "Albert Cahalan" <acahalan@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [RFC/PATCH] revoke/frevoke system calls
Cc: froese@gmx.de, B.Steinbrink@gmx.de, hurtta+gmane@siilo.fmi.fi,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <84144f020608070345q58a9c12btc2eb57cd7bf8dd14@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <787b0d920607220105l21251402nc98381edbc27a0c5@mail.gmail.com>
	 <84144f020608070345q58a9c12btc2eb57cd7bf8dd14@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> [Albert Cahalan]
>> Edgar Toernig writes:

> > > Urgs, so any user may remove mappings from another process and
> > > let it crash?
> > Two good solutions come to mind:
> >
> > a. substitute the zero page
> > b. make the mapping private and touch it as if C-O-W happened
>
> Actually, I think revokeat() and frevoke() should be consistent with
> mmap which will make a process go SIGBUS if it attempts to write to
> truncated shared mapping.

You're right. Apps must already be tolerant of SIGBUS.
There is thus no additional risk.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbWC0QRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWC0QRx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750968AbWC0QRx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:17:53 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:27964 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750960AbWC0QRu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:17:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W5ba2bvtvWFfzalPa67HesYWbhzsw0Zgl4dYhH7B7+Q6dFmADjLn4LhO4yEQ+Ve/qdOgX+vpqxAUfAWGixXlTIoHEkv63T5+xIgwhQHjpvR45hlAOvxwqbgV+GoMvUYRFNMn0lyG6KBsYQXtJ+FQaU8tj45QaWqq/yYp/ltwTQg=
Message-ID: <afcef88a0603270817u6a32e37wb00c1aa9533bffe5@mail.gmail.com>
Date: Mon, 27 Mar 2006 10:17:48 -0600
From: "Michael Thompson" <michael.craig.thompson@gmail.com>
To: "James Morris" <jmorris@namei.org>
Subject: Re: eCryptfs Design Document
Cc: "Michael Halcrow" <mhalcrow@us.ibm.com>, "Andrew Morton" <akpm@osdl.org>,
       phillip@hellewell.homeip.net, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, viro@ftp.linux.org.uk, mike@halcrow.us,
       mcthomps@us.ibm.com, yoder1@us.ibm.com, toml@us.ibm.com,
       emilyr@us.ibm.com, daw@cs.berkeley.edu
In-Reply-To: <Pine.LNX.4.64.0603241757090.27964@excalibur.intercode>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060324222517.GA13688@us.ibm.com>
	 <Pine.LNX.4.64.0603241757090.27964@excalibur.intercode>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/06, James Morris <jmorris@namei.org> wrote:
> On Fri, 24 Mar 2006, Michael Halcrow wrote:
>
> > initialization vector by taking the MD5 sum of the file encryption
> > key; the root IV is the first N bytes of that MD5 sum, where N is the
> > number of bytes constituting an initialization vector for the cipher
> > being used for the file (it is worth noting that known plaintext
> > attacks against the MD5 hash algorithm do not affect the security of
> > eCryptfs, since eCryptfs only hashes secret values).
>
> What about other attacks on MD5?  Hard coding it into the system makes me
> nervous, what about making this selectable?
>
> > By default, eCryptfs selects AES-128. Later versions of eCryptfs will
> > allow the user to select the cipher and key length.
>
> Also, what about making the encryption mode selectable, to at least allow
> for like LRW support in addition to CBC?

These are part of the eCryptfs roadmap. I'm not sure when we are
planning to incorperate the functionality to select your hash and
cipher (I believe its 0.2 or 0.3), but we have experimented with this
and have had success doing so. The code is not included in 0.1 due to
lack of testing and conflict with our mental model of the releases.

Should this functionality be high desired / required, I see no reason
why it can't be added, but Mike Halcrow and Phillip need to weight in
on this too :)

--
Michael C. Thompson <mcthomps@us.ibm.com>
Software-Engineer, IBM LTC Security

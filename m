Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751406AbVKCWZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbVKCWZP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 17:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbVKCWZO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 17:25:14 -0500
Received: from xproxy.gmail.com ([66.249.82.199]:4653 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751406AbVKCWZM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 17:25:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YHCLw9FUfpRlJMPpoWEG+Ee1zVYKa8Z9F2asmx2z0LAAUbqYvvPCwUZopNcjrSzZ1KFledyXpInVcvvIaWmaEKnKaj+sNji28eRdTv/ay0e1W6OIP+ct5ZMBueoX0aAnEVB5gg02rzR66OffNUvAP8kJObMF4TUsZXbT/2dU5Qk=
Message-ID: <afcef88a0511031425u1fa5838fic86cbd7a341cb0a6@mail.gmail.com>
Date: Thu, 3 Nov 2005 16:25:12 -0600
From: Michael Thompson <michael.craig.thompson@gmail.com>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Subject: Re: [PATCH 12/12: eCryptfs] Crypto functions
Cc: Phillip Hellewell <phillip@hellewell.homeip.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       mike@halcrow.us, mhalcrow@us.ibm.com, mcthomps@us.ibm.com,
       yoder1@us.ibm.com
In-Reply-To: <1131055610.9365.17.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051103033220.GD2772@sshock.rn.byu.edu>
	 <20051103035659.GL3005@sshock.rn.byu.edu>
	 <1131055610.9365.17.camel@kleikamp.austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/05, Dave Kleikamp <shaggy@austin.ibm.com> wrote:
> On Wed, 2005-11-02 at 20:56 -0700, Phillip Hellewell wrote:
> > +       ecryptfs_fput(lower_file);
>
> Why the call to ecryptfs_fput() here?  The caller does it's own fput on
> lower_file.

Hmm, good catch. That slipped through us - and to be hoenst, I have no
explination other than, it's wrong. ecryptfs_write_headers should not
be responsible for put'ing that which it did not get.

I'm wondering if I should be sending 1 patch per tiny fix like this,
or if I should be waiting for a few more changes, so as to not flood
the threads with minor patches?

Thanks,
Mike

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261902AbSIYDq1>; Tue, 24 Sep 2002 23:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261905AbSIYDq0>; Tue, 24 Sep 2002 23:46:26 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:21412 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S261902AbSIYDqY>; Tue, 24 Sep 2002 23:46:24 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 25 Sep 2002 13:51:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15761.12992.408142.964391@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module rewrite 2/20: bigrefs
In-Reply-To: message from Rusty Russell on Wednesday September 25
References: <20020925032201.CF8A72C14D@lists.samba.org>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday September 25, rusty@rustcorp.com.au wrote:
> +static inline void bigref_init(struct bigref *ref, int value)
> +{
> +	unsigned int i;
> +	atomic_set(&ref->ref[0].counter, value);
> +	for (i = 1; i < NR_CPUS; i++)
-----------------^
> +		atomic_set(&ref->ref[i].counter, 0);
> +	ref->waiter = NULL; /* To trap bugs */
> +}

Should this be '0', or should there be a comment explaining why it
one?

NeilBrown

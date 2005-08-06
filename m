Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263154AbVHFCrv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbVHFCrv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 22:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbVHFCrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 22:47:51 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:46577 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263154AbVHFCrp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 22:47:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Uq0VodGPqw3lgM2t6wJmgTC6VF+47mILkvk6lzRjL4pBCAMhRI7TjXY2REhe1Wkrh5DJ/Kdyh2iQyfO4CFNVz7OGyVb5Xp3r8KLqdSoKfPDKShaLDtCews5XQq7JlS9nmQ4XNWeF2Uw5+pQCljPQ5csposba8GH40+D9+4W9Suc=
Message-ID: <86802c44050805194779379932@mail.gmail.com>
Date: Fri, 5 Aug 2005 19:47:41 -0700
From: yhlu <yhlu.kernel@gmail.com>
To: Roland Dreier <rolandd@cisco.com>
Subject: Re: mthca and LinuxBIOS
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <52hde36ee8.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20057281331.dR47KhjBsU48JfGE@cisco.com> <52mznxacbp.fsf@cisco.com>
	 <86802c4405080410236ba59619@mail.gmail.com>
	 <86802c4405080411013b60382c@mail.gmail.com> <521x59a6tb.fsf@cisco.com>
	 <86802c440508041230143354c2@mail.gmail.com> <52slxp6o5b.fsf@cisco.com>
	 <86802c440508051103500f6942@mail.gmail.com>
	 <86802c44050805175757f6ff6a@mail.gmail.com> <52hde36ee8.fsf@cisco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I remember last year when I used IBGOLD 0.5 with PCI-X IB card, it
seems that it could support 64 bit pref mem.

I will try IBGOLD 1.7 .....

YH

On 8/5/05, Roland Dreier <rolandd@cisco.com> wrote:
>    yhlu> Roland, what is the -16 mean?
> 
>    yhlu> is it /* Attempt to modify a QP/EE which is not in the
>    yhlu> presumed state: */ MTHCA_CMD_STAT_BAD_QPEE_STATE = 0x10,
> 
> No, -16 is just -EBUSY.  You could put a printk in event_timeout() in
> mthca_cmd.c to make sure, but I'm pretty sure that's where it's coming
> from.  In other words we issue the CONF_SPECIAL_QP firmware command
> and don't ever get a response back from the HCA.
> 
>  - R.
>

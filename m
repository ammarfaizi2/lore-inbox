Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbWCNPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbWCNPMh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 10:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWCNPMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 10:12:37 -0500
Received: from nproxy.gmail.com ([64.233.182.204]:4084 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932205AbWCNPMg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 10:12:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Lfz+HTyWhRhGCejSMeMP44WU66ZIasYeRhIh1aOluVKTrM/Ccx29XF2W+1q+4lv5+9ehFx9R8yNlqmpd542+CYvVWlwZRdHYEo74F1EXeeVR84/MuSFTVgYM02v2Ehe5Di6AieNCG/zJjUaGFUzXG4Vc3JZ8S64mANVkIhFtsd4=
Message-ID: <b6c5339f0603140712u1ff66dedv96f317fda0d949bb@mail.gmail.com>
Date: Tue, 14 Mar 2006 10:12:33 -0500
From: "Bob Copeland" <email@bobcopeland.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 2.6.16-rc6] Promise SuperTrak driver
Cc: "Jeff Garzik" <jeff@garzik.org>, "Ed Lin" <ed.lin@promise.com>,
       "Andrew Morton" <akpm@osdl.org>,
       "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
       "promise_linux@promise.com" <promise_linux@promise.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <1142329204.3027.26.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <NONAMEBgJJ72jYxDwLd000000d3@nonameb.ptu.promise.com>
	 <1142327906.3027.24.camel@laptopd505.fenrus.org>
	 <44168C86.8060107@garzik.org>
	 <1142329204.3027.26.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/06, Arjan van de Ven <arjan@infradead.org> wrote:
> On Tue, 2006-03-14 at 04:27 -0500, Jeff Garzik wrote:
> > I thought that was unnecessary if the struct members are ordered such
> > that compiler would not add padding?
>
> the rules for when padding gets added are different for each platform
> though; worst case of adding it is that it serves as documentation that
> the layout matters :)

I thought the worst case of adding it is that GCC produces awful code
when accessing structure members for __attribute__((packed)) items[1].
 Maybe -Wpadded would be better?

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m=108829229128091

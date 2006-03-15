Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWCOK26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWCOK26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 05:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWCOK26
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 05:28:58 -0500
Received: from nproxy.gmail.com ([64.233.182.193]:63051 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932298AbWCOK25 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 05:28:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MQT0GKCtAdR5V18L9ka9VOTO7cfAhT6feloaLmu0jVS6oQRD9Xry3MAaI+qB0l/1/myWSYZ26jGaUdaE/IewlWnit2Gs3ZqE3fsPCpWJCRfZFwDBkVYMI1lT+CRUaGs7k2WztMO/rgJ9glH7myT5luLE/HX7WXl8e1NTlH15lLs=
Message-ID: <661de9470603150228j3f0ac7bej5f5c21473d5313a6@mail.gmail.com>
Date: Wed, 15 Mar 2006 15:58:55 +0530
From: "Balbir Singh" <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [Patch 1/9] timestamp diff
Cc: nagar@watson.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1142418194.3021.8.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142296939.5858.6.camel@elinux04.optonline.net>
	 <1142418194.3021.8.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> > +static inline void timespec_diff(struct timespec *start, struct timespec *end,
> > +                              struct timespec *ret)
> > +{
> > +     ret->tv_sec = end->tv_sec - start->tv_sec;
> > +     ret->tv_nsec = end->tv_nsec - start->tv_nsec;
> > +}
> >  #endif /* __KERNEL__ */
>
> I'd suggest normalizing the timespec; better to do it in such a function
> than in all callers of it..
>

Yep, that also looks semantically correct. We will do so.

Thanks,
Balbir

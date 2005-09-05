Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932283AbVIEIAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVIEIAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVIEIAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:00:54 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:39129 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932282AbVIEIAw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:00:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hlobLDFBNPM2/SOStzlrBau5MMC4rUQKl30Ob3AjoRBfJMYCbumDEo20iJYNKBUFlYShqttCubDoKHC+RNrwQcEkm5QngbD5KYq52y0H1duKleAZFqrF9pH8jPXn6xa8ZvgdHF+qe4Jw+sGp4W+pmTrMffj9QZQk4hd5+/EDLTM=
Message-ID: <84144f02050905010066bc516d@mail.gmail.com>
Date: Mon, 5 Sep 2005 11:00:51 +0300
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Subject: Re: GFS, what's remaining
Cc: Arjan van de Ven <arjan@infradead.org>, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <20050905075528.GB17607@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901104620.GA22482@redhat.com>
	 <1125574523.5025.10.camel@laptopd505.fenrus.org>
	 <20050905054348.GC11337@redhat.com>
	 <84144f02050904233274d45230@mail.gmail.com>
	 <20050905075528.GB17607@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, David Teigland <teigland@redhat.com> wrote:
> Either set could be trivially removed.  It's such an insignificant issue
> that I've removed glock_hold and put.  For the record,
> 
> within glock.c we consistently paired inlined versions of:
>         glock_hold()
>         glock_put()
> 
> we wanted external versions to be appropriately named so we had:
>         gfs2_glock_hold()
>         gfs2_glock_put()
> 
> still not sure if that technique is acceptable in this crowd or not.

You still didn't answer my question why you needed two versions,
though. AFAIK you didn't which makes the other one an redundant
wrapper which are discouraged in kernel code.

                               Pekka

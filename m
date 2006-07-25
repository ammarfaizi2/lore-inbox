Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWGYWxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWGYWxh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030218AbWGYWxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 18:53:37 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:411 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030212AbWGYWxg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 18:53:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lMM2hcTpOpI6RtpZY6CE0mBPKviatLh52i9UiQA0EcSq0eqL+snvYVM+vplNPaQjRydTnXzYE40MtogtSb5YMGU4zaHR0FcFt+YXmGSJms7ll95PeATA3mvQyrfmfRPJvR0FmVVXG3BVxUjpu1VkpXK/F1ntQ+lAhlE1e4Dm1o0=
Message-ID: <9a8748490607251553u23502237l46df6103d7dc625c@mail.gmail.com>
Date: Wed, 26 Jul 2006 00:53:34 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: [PATCH] CCISS: Don't print driver version until we actually find a device
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Andrew Morton" <akpm@osdl.org>,
       "Mike Miller" <mike.miller@hp.com>, iss_storagedev@hp.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <200607251651.59697.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607251636.42765.bjorn.helgaas@hp.com>
	 <9a8748490607251543w7496864dtd587abc45b93394a@mail.gmail.com>
	 <1153867675.8932.68.camel@laptopd505.fenrus.org>
	 <200607251651.59697.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Tuesday 25 July 2006 16:47, Arjan van de Ven wrote:
> > On Wed, 2006-07-26 at 00:43 +0200, Jesper Juhl wrote:
> > > On 26/07/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > > > If we don't find any devices, we shouldn't print anything.
> > > >
> > > I disagree.
> > > I find it quite nice to be able to see that the driver loaded even if
> > > it finds nothing. At least then when there's a problem, I can quickly
> > > see that at least it is not because I didn't forget to load the
> > > driver, it's something else. Saves time since I can start looking for
> > > reasons why the driver didn't find anything without first spending
> > > additional time checking if I failed to cause it to load for some
> > > reason.
> >
> > I'll add a second reason: it is a REALLY nice property to be able to see
> > which driver is started last in case of a crash/hang, so that the guilty
> > party is more obvious..
>
> initcall_debug is a more reliable way to find that.  Do you want
> all drivers to print something in their init function?

It's not my call, but that would be my personal preference, yes.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

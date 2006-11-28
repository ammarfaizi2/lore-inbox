Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935088AbWK1Dyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935088AbWK1Dyq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 22:54:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935091AbWK1Dyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 22:54:45 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:40089 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S935072AbWK1Dyo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 22:54:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kgqx3Ay3/FUD/t8qVMuDTjqvVD/M1jn8WfsHSGncZhAU+bBoLpeJhDFVOhmb42y/g3upcxtrWNTPFl4/uZ0u5P6iRjpTXRXxi5pe1l9RU7M60EokDHhtWqJ1fhzZuJrMzRxt8slfx6iV8JFztT9uOwKjBSest9E7DVJLhY+ZHqA=
Message-ID: <39e6f6c70611271954s7cc3b6bbo237e333ae0d810ea@mail.gmail.com>
Date: Tue, 28 Nov 2006 01:54:43 -0200
From: "Arnaldo Carvalho de Melo" <arnaldo.melo@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: [2.6 patch] kill net/rxrpc/rxrpc_syms.c
Cc: "David Howells" <dhowells@redhat.com>, "Adrian Bunk" <bunk@stusta.de>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061127193313.d59f61f0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061126040416.GH15364@stusta.de> <30354.1164626485@redhat.com>
	 <20061127193313.d59f61f0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/06, Andrew Morton <akpm@osdl.org> wrote:
> On Mon, 27 Nov 2006 11:21:25 +0000
> David Howells <dhowells@redhat.com> wrote:
>
> > Adrian Bunk <bunk@stusta.de> wrote:
> >
> > > This patch moves the EXPORT_SYMBOL's from net/rxrpc/rxrpc_syms.c to the
> > > files with the actual functions.
> >
> > You can if you like.  Can you slap a blank line before each EXPORT_SYMBOL()
> > though please?
>
> We have a mixture of both styles and given that they waste space in return
> for no added value, people have been gradually removing these blank lines
> in many places.  Please don't add more.

Agreed, good thing would be if we could have something like

void foo(int bar) gpl_exported
{
}

I.e. some kind of __attribute__, nah, I should just get some sleep :-)

- Arnaldo

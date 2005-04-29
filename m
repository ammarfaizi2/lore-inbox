Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262445AbVD2HMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262445AbVD2HMp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 03:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262448AbVD2HMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 03:12:45 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:14312 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262445AbVD2HMn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 03:12:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y0INYF7/hKVlflrPCOy+R9dEmd4NzO2R/uhtZpLpVonmHU2SNQ+VGlp0yhUZHYJ86XScxweDuWOQEH2sQ2/PhrmoYLLtgWNY3miI99mjbkpsHuFbWnJWqu4pi/zkCPhneemN9oQ3zRvM0YGdyBPRYWcKDgv5hM+UVFWPSwOgifw=
Message-ID: <ba835822050429001234304bd1@mail.gmail.com>
Date: Fri, 29 Apr 2005 00:12:43 -0700
From: Gilles Pokam <gpokam@gmail.com>
Reply-To: Gilles Pokam <gpokam@gmail.com>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: Kernel memory
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050429064819.GA15501@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <ba83582205042816522e2a7a93@mail.gmail.com>
	 <20050429030313.GA10344@taniwha.stupidest.org>
	 <ba8358220504282233754de43b@mail.gmail.com>
	 <20050429054351.GA12654@taniwha.stupidest.org>
	 <ba8358220504282248344d5e78@mail.gmail.com>
	 <20050429061254.GB12654@taniwha.stupidest.org>
	 <ba83582205042823452a3446f6@mail.gmail.com>
	 <20050429064819.GA15501@taniwha.stupidest.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Chris Wedgwood <cw@f00f.org> wrote:
> On Thu, Apr 28, 2005 at 11:45:40PM -0700, Gilles Pokam wrote:
> 
> > the simplest way to say is: I want the pagefault handler to return a
> > memory page when it encounters a pagefault exceptions due to an
> > invalid address or incorrect page protection.
> 
> where should this page come from?

One way is to make the pagefault handler return a new vma that
contains the faulty address when such a scenario is encountered. The
normal pagefault mechanism will then apply by the time that address
gets accessed again since the address will now be valid. So a page
will be allocated. But I don't know how what should be changed  in the
kernel to enable this behavior.

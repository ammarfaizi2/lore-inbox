Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285072AbRLLDhk>; Tue, 11 Dec 2001 22:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbRLLDhU>; Tue, 11 Dec 2001 22:37:20 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:50443 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S285072AbRLLDhM>; Tue, 11 Dec 2001 22:37:12 -0500
Date: Tue, 11 Dec 2001 22:37:11 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Steven Walter <srwalter@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] v2.5.1-pre9-00_kvec.diff
Message-ID: <20011211223711.C17550@redhat.com>
In-Reply-To: <20011211162639.F6878@redhat.com> <20011211213515.D29224@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011211213515.D29224@hapablap.dyn.dhs.org>; from srwalter@yahoo.com on Tue, Dec 11, 2001 at 09:35:15PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 11, 2001 at 09:35:15PM -0600, Steven Walter wrote:
> > +	nr_pages = (ptr + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
> > +	nr_pages -= ptr >> PAGE_SHIFT;
> 
> Isn't this the same as
> 	nr_pages = (len + PAGE_SIZE -1) >> PAGE_SHIFT;

No.

> ?  Or am I missing something?

Yes.  Pointers may not be page aligned.

		-ben
-- 
Fish.

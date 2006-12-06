Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760625AbWLFOCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760625AbWLFOCt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 09:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760627AbWLFOCt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 09:02:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:32766 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760625AbWLFOCs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 09:02:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=JBAqNFTvLF4QIiKsKNl66FCQgO6pScLxD59ertH7m4SWgjF5EJqQiN27/gd+Ju2cJZc6g0McLVhslm58NEqP8rGqI8I47XfZZrVZS9rMipjgH/Y0eidtdGr1wa0iJo6bjqShClfQ1nPImTD9kpi8NajWmbm4LEV3imCXAUxY8WU=
Date: Wed, 6 Dec 2006 14:01:38 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Phil Endecott <phil_arcwk_endecott@chezphil.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Subtleties of __attribute__((packed))
Message-ID: <20061206140138.GA16350@slug>
References: <1165411241721@dmwebmail.belize.chezphil.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165411241721@dmwebmail.belize.chezphil.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2006 at 01:20:41PM +0000, Phil Endecott wrote:
> Dear All,
> 
> I used to think that this:
> 
> struct foo {
>   int a  __attribute__((packed));
>   char b __attribute__((packed));
>   ... more fields, all packed ...
> };
> 
> was exactly the same as this:
> 
> struct foo {
>   int a;
>   char b;
>   ... more fields ...
> } __attribute__((packed));
> 
> but it is not, in a subtle way.
> 
This is likely a gcc bug isn't it? The gcc info page states:
  Specifying this attribute for `struct' and `union' types is
  equivalent to specifying the `packed' attribute on each of the
  structure or union members.

Regards,
Frederik

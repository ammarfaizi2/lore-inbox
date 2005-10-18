Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbVJRUsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVJRUsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVJRUsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:48:42 -0400
Received: from qproxy.gmail.com ([72.14.204.203]:132 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932071AbVJRUsm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:48:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=PwYcwNO4CY8/EqVRYEHX0UmeKCRVPP9XDukqkkwtxnK2yQmb6aRShZUjIY1KeeFx7l0x2Oa1rQgnVguU/VQWLS1Tts7YILJ4nt6cJIyvTpoX+/+Kgu2l7p8FE3VSd1EwuUmk+VhYXHfzcY5qnGaCGOOzCZXfYwOdgEq4QFHDj/0=
Subject: Re: large files unnecessary trashing filesystem cache?
From: Badari Pulavarty <pbadari@gmail.com>
To: Guido Fiala <gfiala@s.netic.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200510182201.11241.gfiala@s.netic.de>
References: <200510182201.11241.gfiala@s.netic.de>
Content-Type: text/plain
Date: Tue, 18 Oct 2005 13:48:04 -0700
Message-Id: <1129668484.23632.82.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-18 at 22:01 +0200, Guido Fiala wrote:
> (please note, i'am not subscribed to the list, please CC me on reply)
> 
> Story:
> Once in while we have a discussion at the vdr (video disk recorder) mailing 
> list about very large files trashing the filesystems memory cache leading to 
> unnecessary delays accessing directory contents no longer cached.
> 
> This program and certainly all applications that deal with very large files 
> only read once (much larger than usual memory)  - it happens that all other 
> cached blocks of the filessystem are removed from memory solely to keep as 
> much as possible of that file in memory, which seems to be a bad strategy in 
> most situations.
> 
> Of course one could always implement f_advise-calls in all applications, but i 
> suggest a discussion if a maximum (configurable) in-memory-cache on a 
> per-file base should be implemented in linux/mm or where this belongs.
> 
> My guess was, it has something to do with mm/readahead.c, a test limiting the 
> result of the function "max_sane_readahead(...) to 8 MBytes as a quick and 
> dirty test did not solve the issue, but i might have done something wrong.
> 
> I've searched the archive but could not find a previous discussion - is this a 
> new idea?
> 
> It would be interesting to discuss if and when this proposed feature could 
> lead to better performance or has any unwanted side effects.
> 
> Thanks for ideas on that issue.

Is there a reason why those applications couldn't use O_DIRECT ?

Thanks,
Badari


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbVLNUJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbVLNUJk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 15:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964862AbVLNUJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 15:09:40 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:41604 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964797AbVLNUJj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 15:09:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=saziPPbbpCfHlWV6fIFE54cCetaEyRmuw0hgVSUdnBHW7BVV1Mq2NmcYySZQFvZRA/2vhacK/l8HGcTvcVjytircUC3RJe756DDArHJw3UYo9UGe0MD9XanVM067KaXXqdrl9WZ8I4mS0q2KkdCggnOtlfGRAmf873uMtTDXnPc=
Message-ID: <8746466a0512141209g569d2870u4aba3fe7a68fe51c@mail.gmail.com>
Date: Wed, 14 Dec 2005 13:09:38 -0700
From: Dave <dave.jiang@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86_64 segfault error codes
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051214195848.GQ23384@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <8746466a0512141017j141d61dft3dd2b1ab95dc2351@mail.gmail.com>
	 <p73hd9b8r9w.fsf@verdi.suse.de>
	 <8746466a0512141124u68c3f5c9o3411c8af64667d8d@mail.gmail.com>
	 <20051214195848.GQ23384@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/05, Andi Kleen <ak@suse.de> wrote:
> On Wed, Dec 14, 2005 at 12:24:42PM -0700, Dave wrote:
> > Ah ok, thx! Looks like the comment in mm/fault.c is wrong then.... It
> > says bit 3 is instruction fetch and no mention of bit 4.
>
> Don't know what kernel you're looking at, but 2.6.15rc5 has
>
>  *      bit 0 == 0 means no page found, 1 means protection fault
>  *      bit 1 == 0 means read, 1 means write
>  *      bit 2 == 0 means kernel, 1 means user-mode
>  *      bit 3 == 1 means use of reserved bit detected
>  *      bit 4 == 1 means fault was an instruction fetch

Ah sorry. Was looking at 2.6.14.

--
-= Dave =-

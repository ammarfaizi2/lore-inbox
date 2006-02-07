Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964853AbWBGTXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964853AbWBGTXn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 14:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbWBGTXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 14:23:43 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:46904 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964853AbWBGTXn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 14:23:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IaJ1bVm6zYbujavaB+6JrkuXcbkVsCEKos1kmZ6wEjJ9vTXcAF9KftreHt/foCZTj0+ITk5WGYjA+siRQ1ssTWh1ibBRoSQOizTKiEQbhqs1LbFCDNeakxgZUD24pQ/YfdjE+a3gWKoEEB8IOj3Ms21yBFHgCBtFcg74cKTMpdM=
Message-ID: <a36005b50602071123r8179c7di8e95bf0a336f1b0c@mail.gmail.com>
Date: Tue, 7 Feb 2006 11:23:42 -0800
From: Ulrich Drepper <drepper@gmail.com>
To: Jeff Dike <jdike@addtoit.com>
Subject: Re: [PATCH 2/8] UML - Define jmpbuf access constants
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
In-Reply-To: <20060207185707.GB6841@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602070223.k172NpJa009654@ccure.user-mode-linux.org>
	 <a36005b50602070937h60e35294q1dbef2c21f2fb50d@mail.gmail.com>
	 <20060207185707.GB6841@ccure.user-mode-linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/7/06, Jeff Dike <jdike@addtoit.com> wrote:
> Nope, that would be the next step if this turned out to be untenable,
> which I guess it is.

You have to do it if you want to keep using the setjmp interface.


> You're actually encrypting them somehow?  How?  And why?

For security reasons.


> Is there a reason there can't be an API for looking at the contents of
> a jmp_buf?

It's not needed.  There is no reason to look at the content of the
struct except if you do something which isn't guaranteed by the spec. 
I'll definitely not add such an interface.  If you need this
functionality, implement it yourself.  setjmp is most likely overkill
anyway.

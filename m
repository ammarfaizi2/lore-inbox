Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbVDYNH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbVDYNH0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 09:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbVDYNHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 09:07:25 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:24345 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262604AbVDYNHV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 09:07:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=iv+TPhuD2/KfpOFmXKNtSjSlzN81aFkXaW0QnFuy3QHLDLLCy+ltZ0yfiKlFYFY1JIlEB3JuPA9bJheNSnnOSM8kALSy4maMaOIjpYrNqpZkU3Nk2IyJM8WVAKtjQXamkZNXBwrvD7/jbVdCRZn2elSCFnovkZQER7vUZUHsiHQ=
Message-ID: <84144f02050425060763f92b7@mail.gmail.com>
Date: Mon, 25 Apr 2005 16:07:20 +0300
From: Pekka Enberg <penberg@gmail.com>
Reply-To: Pekka Enberg <penberg@gmail.com>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
Cc: Matthias-Christian Ott <matthias.christian@tiscali.de>,
       Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050425123236.GC26665@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <426CD1F1.2010101@tiscali.de> <20050425123236.GC26665@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/05, Petr Baudis <pasky@ucw.cz> wrote:
> Honestly, I don't think using the register keyword helps anything but to
> make the code less readable.

Indeed. The use of 'register' keyword blindly can actually make the
generated code _worse_ as it taking away one register from the
compiler's register allocator.

                        Pekka

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293199AbSCEOmz>; Tue, 5 Mar 2002 09:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293206AbSCEOmp>; Tue, 5 Mar 2002 09:42:45 -0500
Received: from mnh-1-04.mv.com ([207.22.10.36]:50181 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S293199AbSCEOm3>;
	Tue, 5 Mar 2002 09:42:29 -0500
Message-Id: <200203051443.JAA02119@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] Arch option to touch newly allocated pages 
In-Reply-To: Your message of "Mon, 04 Mar 2002 23:28:06 EST."
             <20020304232806.A31622@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 05 Mar 2002 09:43:39 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bcrl@redhat.com said:
> you only need to do the memsets once at  startup of UML where the ram
> is allocated -> a uml booted with 64MB of  ram would write into every
> page of the backing store file before even  running the kernel.
> Doesn't that accomplish the same thing?

The other reason I don't like this is that, at some point, I'd like to
start thinking about userspace cooperating with the kernel on memory
management.  UML looks like a perfect place to start since it's essentially
identical to the host making it easier for the two to bargain over memory.

Having UML react sanely to unbacked pages is a step in that direction, having
UML preemptively grab all the memory it could ever use isn't.

				Jeff


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751603AbWJMD40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751603AbWJMD40 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 23:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751604AbWJMD40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 23:56:26 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:714 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751597AbWJMD4Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 23:56:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=STKUNX33ji2uqoBo3J5h8R6ACA204UPm7RmlUo9EKYZzE987KYTDpkhuMqfWIavg/ua9dD5nwZIAXnZ6cGUg0zLmYzYp/ecI7GBER9jANcugKBY23rzFOniLxhePh85g4hWimglLTn7A4dQPgwzCUco3Zckas+P7szBh1Rkc5Co=
Message-ID: <9ecacaab0610122055u734f8858p86c0b6f1f918f4af@mail.gmail.com>
Date: Thu, 12 Oct 2006 23:55:51 -0400
From: "David Dumas" <daviddumas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: sx8 on x86-64 instability with kernels >= 2.6.16
In-Reply-To: <9ecacaab0610120851i64c9e22fqc038c88e3fbe892f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9ecacaab0610120851i64c9e22fqc038c88e3fbe892f@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/06, David Dumas <daviddumas@gmail.com> wrote:
> As for kernel configuration, I have tried both debian stock amd64
> kernels and a custom kernel configured as close to the working 2.6.15
> kernel as possible.

It turns out that these test cases were slightly flawed, in that the
default io scheduler was not that same for all of them.  Debian
recently changed the default io scheduler for their stock kernels.

Now it looks like the problem is an incompatibility between the CFQ
scheduler and the sx8 driver (on both i386 and x86-64).  I'll
investigate this further.

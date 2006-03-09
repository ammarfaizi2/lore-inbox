Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751769AbWCIV7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbWCIV7A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbWCIV7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:59:00 -0500
Received: from web52602.mail.yahoo.com ([206.190.48.205]:7575 "HELO
	web52602.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751769AbWCIV7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:59:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pOkaW8dwMlnMNvqgH7/ItCjFRkW/1mFzqsuIEylYYaqpUtJwc3uZp572WolwHJft0fVHOKDJ8wHySza111xhR3dOn2++DFDUe0fAQMBH8OWgd8i51OuF4UsAafnN2JqjCobCu55gI4BB2LKrjTepc3EBfhettbGCQLmtZyAJJ1M=  ;
Message-ID: <20060309215857.73032.qmail@web52602.mail.yahoo.com>
Date: Fri, 10 Mar 2006 08:58:57 +1100 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: Oops on ibmasm
To: Max Asbock <masbock@us.ibm.com>
Cc: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Vernon Mauery <vernux@us.ibm.com>
In-Reply-To: <1141925840.6240.18.camel@w-amax>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Max Asbock <masbock@us.ibm.com> wrote:
> [...snip...]
> cmd->lock points to a persistent lock that is not
> freed with cmd. 

Thanks for the patch Max.

> ibmasm driver:
> Fix the command_put() function which uses a pointer
> for a spinlock that
> can be freed before dereferencing it.

Yup, that patch fixes the oops when slab debug is
enabled.

Assuming there are no unforseen regressions, may I
request for its inclusion in the upcoming 2.6.16?

Hari.


		
____________________________________________________ 
On Yahoo!7 
Photos: Unlimited free storage – keep all your photos in one place! 
http://au.photos.yahoo.com 


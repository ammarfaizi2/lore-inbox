Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbWKBKvH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbWKBKvH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 05:51:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWKBKvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 05:51:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:45593 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750747AbWKBKvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 05:51:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jCZyvrU0oHj0f8V+ChhdlynVcDB1ript/y4NeyaqRWp1hQyqRymEZr6BygOMf3XlaognBo09rG5PnMByetbUGMoyiNtKM2ZwUviFJqPP5gQSRFWoOdcGg0StvVBhkbIJ/RLWGvvDbrrep9a1mtJDE4cYoVvyeaYW/h0B2mEEvZk=
Message-ID: <aec7e5c30611020251p7375fb39ne1f5aba8ea14a3a2@mail.gmail.com>
Date: Thu, 2 Nov 2006 19:51:02 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Jakub Jelinek" <jakub@redhat.com>
Subject: Re: [PATCH 01/02] Elf: Always define elf_addr_t in linux/elf.h
Cc: "Magnus Damm" <magnus@valinux.co.jp>, linux-kernel@vger.kernel.org,
       "Vivek Goyal" <vgoyal@in.ibm.com>, "Andi Kleen" <ak@muc.de>,
       fastboot@lists.osdl.org, Horms <horms@verge.net.au>,
       "Dave Anderson" <anderson@redhat.com>, ebiederm@xmission.com
In-Reply-To: <20061102104305.GD24872@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061102101942.452.73192.sendpatchset@localhost>
	 <20061102104305.GD24872@devserv.devel.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/06, Jakub Jelinek <jakub@redhat.com> wrote:
> On Thu, Nov 02, 2006 at 07:19:42PM +0900, Magnus Damm wrote:
> > --- 0001/include/linux/elf.h
> > +++ work/include/linux/elf.h  2006-11-02 15:44:10.000000000 +0900
> > @@ -352,12 +352,16 @@ typedef struct elf64_note {
> >    Elf64_Word n_type; /* Content type */
> >  } Elf64_Nhdr;
> >
> > +typedef Elf64_Off elf64_addr;
> > +typedef Elf32_Off elf32_addr;
> > +
>
> What are these typedefs useful for?  Isn't it better just to
> use Elf32_Addr and Elf64_Addr in the #defines below?

Sure, good idea. I just added them to follow the "style" of the rest
of the file.

Thanks,

/ magnus

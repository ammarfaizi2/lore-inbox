Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751239AbWFBHFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751239AbWFBHFo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWFBHFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:05:44 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:18746 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751239AbWFBHFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:05:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PYwwfFdlk8Yk+FKU+23WUa984YsVxHhNWwSCXWUug9/DxyhF2JEnCs2kjTeAB9be/A6zVoxuyuUSvTc/GK+h7l1WXINcG09OKrUj7XEnRWhpxwGwIRXHj2mnZEeaVtB9rcFPRVLhGzjiHRKQZZL3GP/7O59DcoN4nfbt0vnHeFg=
Message-ID: <9a8748490606020005n841abafjc7e05a5e2ab8a312@mail.gmail.com>
Date: Fri, 2 Jun 2006 09:05:41 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Abu M. Muttalib" <abum@aftek.com>
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       "Paulo Marques" <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
In-Reply-To: <BKEKJNIHLJDCFGDBOHGMGEJJCNAA.abum@aftek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <447F00C7.4060904@mbligh.org>
	 <BKEKJNIHLJDCFGDBOHGMGEJJCNAA.abum@aftek.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/06, Abu M. Muttalib <abum@aftek.com> wrote:
> Hi,
>
> That's precisely I want to say. The PAGES are available but they are not
> allocated to process. Why??
>
There may be 32 pages available in total, but not 32 contiguous ones -
that's a *lot* of contiguous pages to ask for in kernel space - 128KB
(assuming a 4096 byte page size).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html

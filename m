Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWGKR6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWGKR6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 13:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751158AbWGKR6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 13:58:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:64236 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751082AbWGKR6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 13:58:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EzC7pcQCiSb5edYCS31S+ZyDNSYs1J+yYC2ETyK8AZMpdGv16Knv0IJV7huISq1qiyB+BZyFlDXFpmzmTpRsdWFuaViHW3LNAEoWXlsOFtzlEs0vUNwp2fKKFXx+Caegdss7ujWQvif9WnOYucbC6dL7oOqrQHiharG71hc/IsQ=
Message-ID: <d120d5000607111058k1afb2486rca176248fa8bdc74@mail.gmail.com>
Date: Tue, 11 Jul 2006 13:58:41 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Josef Sipek" <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [RFC/PATCH] Introduce list_get() and list_get_tail()
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Andi Kleen" <ak@suse.de>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arnd Bergmann" <arnd@arndb.de>
In-Reply-To: <20060711174331.GA1666@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607080124.21856.dtor@insightbb.com>
	 <p73wtaonqow.fsf@verdi.suse.de>
	 <1152368186.3120.50.camel@laptopd505.fenrus.org>
	 <200607082328.48575.dtor@insightbb.com>
	 <20060711174331.GA1666@filer.fsl.cs.sunysb.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> On Sat, Jul 08, 2006 at 11:28:47PM -0400, Dmitry Torokhov wrote:
> ...
> > +#define list_next_entry list_first_entry
>
> list_next_entry, that sounds almost as something which given any list_head
> will give you the next entry. That's all fine until you give it the last
> list_head in the list - you'll try to use list_entry on a list_head that's
> not part of a struct but is the head of the list instead.
>
> > +#define list_prev_entry list_last_entry
>
> Ditto.

The same could be said about regular list_entry(), however we do have
it and it is pretty useful.

-- 
Dmitry

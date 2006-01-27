Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422689AbWA0XgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422689AbWA0XgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 18:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWA0XgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 18:36:07 -0500
Received: from smtpout.mac.com ([17.250.248.87]:5573 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1422689AbWA0XgG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 18:36:06 -0500
In-Reply-To: <1138400385.8770.21.camel@lade.trondhjem.org>
References: <20060127092817.GB24362@infradead.org> <1138312694656@2gen.com> <1138312695665@2gen.com> <6403.1138392470@warthog.cambridge.redhat.com> <20060127204158.GA4754@hardeman.nu> <1138400385.8770.21.camel@lade.trondhjem.org>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <8155F461-1703-476B-8C5D-B834EE49905D@mac.com>
Cc: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>,
       David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, keyrings@linux-nfs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [Keyrings] Re: [PATCH 01/04] Add multi-precision-integer maths library
Date: Fri, 27 Jan 2006 18:35:40 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 27, 2006, at 17:19, Trond Myklebust wrote:
> On Fri, 2006-01-27 at 21:41 +0100, David Härdeman wrote:
>
>> For example, a backup daemon which wishes to store the backup on  
>> another host using ssh. Usually this is solved by storing an  
>> unencrypted key in the fs or by providing a connection to a ssh- 
>> agent which has been preloaded with the proper key(s). Both are  
>> quite inelegant solutions.  With the in-kernel support, the daemon  
>> can request the key using the request_key call, and (provided  
>> proper scripts are written), the user who controls the relevant  
>> key can supply it. This in turn means that the backup daemon can  
>> sign using the key and read its public parts but not the private key.
>
> ...but why would you want such a daemon to live in the kernel in  
> the first place? A backup application might perhaps need some  
> kernel support in order to ensure filesystem consistency, but that  
> does not mean that moving the entire daemon into the kernel is a  
> good idea.

No, the point is not to put the backup daemon into the kernel, but to  
provide a way for the backup daemon and my user process to  
communicate DSA key details without completely giving the backup  
daemon my key.  I may not entirely trust the backup daemon not to get  
compromised, but with support for the kernel keyring system,  
compromising the backup daemon would only compromise the backed up  
files, not the private keys and other secure data.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer



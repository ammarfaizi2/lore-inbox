Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932131AbWA1LZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932131AbWA1LZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jan 2006 06:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWA1LZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jan 2006 06:25:59 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:33684 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S932131AbWA1LZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jan 2006 06:25:59 -0500
Date: Sat, 28 Jan 2006 12:25:13 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, keyrings@linux-nfs.org
Subject: Re: [PATCH 00/04] Add DSA key type
Message-ID: <20060128112512.GB4348@hardeman.nu>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, dhowells@redhat.com,
	keyrings@linux-nfs.org
References: <11380489522362@2gen.com> <E1F2IJr-0007Gu-00@gondolin.me.apana.org.au> <20060127072345.GB4082@hardeman.nu> <20060127122856.GB32128@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20060127122856.GB32128@gondor.apana.org.au>
User-Agent: Mutt/1.5.11
X-SA-Score: -2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 11:28:56PM +1100, Herbert Xu wrote:
>On Fri, Jan 27, 2006 at 08:23:45AM +0100, David H?rdeman wrote:
>>On Fri, Jan 27, 2006 at 12:22:31PM +1100, Herbert Xu wrote:
>>>The asymmetric encryption support should be done inside the crypto/
>>>framework rather than as an extension to the key management system.
>> 
>> It is done inside the crypto/ framework. crypto/dsa.c implements the DSA 
>> signing as a hash crypto algorithm (since a DSA signature is two 160-bit 
>> integers, the result has a fixed size).
>
>Right.  I mistook the name encrypt to mean generic asymmetric encryption.
>Now I see that it is simply an interface to the signature algorithm.
>This is fine by me.  However, wouldn't "sign" be a better name for it?
>

I don't know, the function which is performed upon the data is 
keytype-specific (i.e. with the dsa key the data is signed, with another 
key type it might be encrypted, etc). So perhaps the operation should be 
given a more generic name such as "crypto".

Re,
David

Return-Path: <linux-kernel-owner+w=401wt.eu-S1161021AbXALHnQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161021AbXALHnQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:43:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161022AbXALHnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:43:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:27977 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161021AbXALHnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:43:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=an98Juzf4mM2/B67RVpDWi7CXN741C14x/VfaRx00j9z2la9N3Ve10o5+3KBRfbi1ThHbdX4iq9gjSznAZPzd93bnO3Q/+CwChPLowb2trx6OxMM11Ksna0KJ5SAt0Jp2uoBW5rQTpyHxPWaL3gmquUE80Y1rP3jbLSBjh6k+0k=
Message-ID: <84144f020701112343n1e398fc4r65fa83717f9e5f02@mail.gmail.com>
Date: Fri, 12 Jan 2007 09:43:10 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: mprotect abuse in slim
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Mimi Zohar" <zohar@us.ibm.com>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@saff.watson.ibm.com
In-Reply-To: <20070111154957.GG4791@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <OFE2C5A2DE.3ADDD896-ON8525725D.007C0671-8525725D.007D2BA9@us.ibm.com>
	 <1168312045.3180.140.camel@laptopd505.fenrus.org>
	 <20070109094625.GA11918@infradead.org>
	 <20070109231449.GA4547@sergelap.austin.ibm.com>
	 <Pine.LNX.4.64.0701100914550.22496@sbz-30.cs.Helsinki.FI>
	 <20070110155845.GA373@sergelap.austin.ibm.com>
	 <84144f020701102339n1935b0a7v5ca3419fe3b66be5@mail.gmail.com>
	 <20070111154957.GG4791@sergelap.austin.ibm.com>
X-Google-Sender-Auth: e36cee2ac50bcc33
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Right, but is returning -EINVAL to userspace on munmap a problem?

Yes, because an application has no way of reusing the revoked mapping
range. The current patch should get this right, though.

On 1/11/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Thanks for the tw other patches - I'll give them a shot and check
> out current munmap behavior just as soon as I get a chance.

I hacked the remaining open issues yesterday so please use this instead:

http://www.cs.helsinki.fi/u/penberg/linux/revoke/revoke-2.6.20-rc4

The one at kernel.org will be updated as well when mirroring catches up.

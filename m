Return-Path: <linux-kernel-owner+w=401wt.eu-S965327AbXAKHjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbXAKHjh (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965326AbXAKHjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:39:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:59559 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965324AbXAKHjg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:39:36 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=twJzQFttTKyq1PXNot3rU5vqbyzlhQI2LGRis0ka34Bg3wjjz8+nGuWRyeMtZwsy3Ikcmu0YLdB0CCTUekyR5uHtsuBJLNgshwaBOna3OXmaE35tEiyQH8zfI2JQICBM3UB5MBmUsHcakzm01Kw4ZoIRwYpFJCyX1S4qej5eXsY=
Message-ID: <84144f020701102339n1935b0a7v5ca3419fe3b66be5@mail.gmail.com>
Date: Thu, 11 Jan 2007 09:39:34 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: mprotect abuse in slim
Cc: "Christoph Hellwig" <hch@infradead.org>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Mimi Zohar" <zohar@us.ibm.com>, akpm@osdl.org,
       kjhall@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
       safford@saff.watson.ibm.com
In-Reply-To: <20070110155845.GA373@sergelap.austin.ibm.com>
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
X-Google-Sender-Auth: 6bb5e6e88973c0fa
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/07, Serge E. Hallyn <serue@us.ibm.com> wrote:
> But since it looks like you just munmap the region now, shouldn't a
> subsequent munmap by the app just return -EINVAL?  that seems appropriate
> to me.

Applications don't know about revoke and neither should they.
Therefore close(2) and munmap(2) must work the same way they would for
non-revoked inodes so that applications can release resources
properly.

                                         Pekka

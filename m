Return-Path: <linux-kernel-owner+w=401wt.eu-S1750873AbWLOBV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWLOBV1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWLOBV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:21:27 -0500
Received: from an-out-0708.google.com ([209.85.132.248]:28853 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbWLOBV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:21:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=iJtDVtv43LGt3Ywj2SiZPxThL/xMk6/S47JnjEGd/NcJmvzanaZQvmfay92hC0a7B7ttF8ITjaVAnWqDA3PermV3X5Kf3ghXMCHe9qhxjbXNRKzH1Q499LK5Q3uu75IWkBAnKsS48X2OBYbADhMoEVwubGGGyaWoyt4DEzlGCS4=
Message-ID: <eb97335b0612141721g2e983574k4ea698caa316de6d@mail.gmail.com>
Date: Thu, 14 Dec 2006 17:21:25 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [patch 2/4] permission mapping for sys_syslog operations
Cc: "Stephen Smalley" <sds@tycho.nsa.gov>, jmorris@namei.org,
       "Chris Wright" <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061214170229.d0f06a57.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061215001639.988521000@panix.com>
	 <20061215002334.039728000@panix.com>
	 <20061214170229.d0f06a57.randy.dunlap@oracle.com>
X-Google-Sender-Auth: be2fa67ffe318a59
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > +#define security_syslog_or_fail(type) do {           \
> > +             int error = security_syslog(type);      \
> > +             if (error)                              \
> > +                     return error;                   \
> > +     } while (0)
> > +
>
> From Documentation/CodingStyle:
>
> Things to avoid when using macros:
>
> 1) macros that affect control flow: ...

It says "avoid", not "never use".  If you can think of another way to
code this function that won't completely obscure the actual operations
with the security checks, I will be happy to change it.

zw

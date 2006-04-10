Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750991AbWDJQHE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750991AbWDJQHE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 12:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbWDJQHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 12:07:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:50362 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750991AbWDJQHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 12:07:01 -0400
Message-ID: <443A829E.1050902@fr.ibm.com>
Date: Mon, 10 Apr 2006 18:06:54 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: devel@openvz.org
CC: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@sw.ru>,
       herbert@13thfloor.at, sam@vilain.net,
       "Eric W. Biederman" <ebiederm@xmission.com>, xemul@sw.ru,
       James Morris <jmorris@namei.org>
Subject: Re: [Devel] [PATCH 4/7] uts namespaces: implement utsname namespaces
References: <20060407234815.849357768@sergelap> <20060408045206.EFDD819B901@sergelap.hallyn.com>
In-Reply-To: <20060408045206.EFDD819B901@sergelap.hallyn.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serge E. Hallyn wrote:
> ...
> -struct new_utsname system_utsname = {
> -	.sysname	= UTS_SYSNAME,
> -	.nodename	= UTS_NODENAME,
> -	.release	= UTS_RELEASE,
> -	.version	= UTS_VERSION,
> -	.machine	= UTS_MACHINE,
> -	.domainname	= UTS_DOMAINNAME,
> +struct uts_namespace init_uts_ns = {
> +	.kref = {
> +		.refcount	= ATOMIC_INIT(2),
> +	},
> +	.name = {
> +		.sysname	= UTS_SYSNAME,
> +		.nodename	= UTS_NODENAME,
> +		.release	= UTS_RELEASE,
> +		.version	= UTS_VERSION,
> +		.machine	= UTS_MACHINE,
> +		.domainname	= UTS_DOMAINNAME,
> +	},
>  };
>  
> -EXPORT_SYMBOL(system_utsname);

this should problably be replaced with

EXPORT_SYMBOL(init_uts_ns);

or export init_utsname().

C.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbWGKS0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbWGKS0M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932079AbWGKS0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:26:12 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:37764 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932078AbWGKS0K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:26:10 -0400
Message-ID: <44B3ED3B.3010401@fr.ibm.com>
Date: Tue, 11 Jul 2006 20:26:03 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sam Vilain <sam.vilain@catalyst.net.nz>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH -mm 0/7] execns syscall and user namespace
References: <20060711075051.382004000@localhost.localdomain> <44B3EA16.1090208@zytor.com>
In-Reply-To: <44B3EA16.1090208@zytor.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:

> I would like give a strong objection to the naming.  The -ve() suffix in
> execve() isn't jettisonable; it indicates its position within a family
> of functions (only one of which is a true system call.)
> 
> execven() would be better name (the -n argument coming after then -e
> argument).  The library could then provide execlen(), execlpn() etc as
> appropriate.

I agree. execns() is a shortcut.

This service behaves like execve() if the flag argument is 0, so I guess we
should keep the execve- prefix. However, we could be a bit more explicit on
the nature of this service and call it execve_unshare().

thanks,

C.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWEJKBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWEJKBD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 06:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964884AbWEJKBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 06:01:03 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:10209 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964883AbWEJKBC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 06:01:02 -0400
Date: Wed, 10 May 2006 11:00:57 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com,
       clg@fr.ibm.com, frankeh@us.ibm.com
Subject: Re: [PATCH 1/9] nsproxy: Introduce nsproxy
Message-ID: <20060510100057.GA27946@ftp.linux.org.uk>
References: <29vfyljM.2006059-s@us.ibm.com> <20060510021129.GB32523@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060510021129.GB32523@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 09, 2006 at 09:11:29PM -0500, Serge E. Hallyn wrote:
> Introduce the nsproxy struct.  Doesn't do anything yet, but has it's
> own lifecycle pretty much mirrorring the fs namespace.
> 
> Subsequent patches will move the namespace struct into the nsproxy.
> Then as more namespaces are introduced, such as utsname, they can
> be added to the nsproxy as well.

Is there any reason why those can't be simply part of namespace?  I.e.
be carried by the stuff mounted in standard places...

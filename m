Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbTEHPbL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 11:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbTEHPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 11:31:10 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64134
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261561AbTEHPbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 11:31:09 -0400
Subject: Re: The disappearing sys_call_table export.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "viro@parcelfarce.linux.theplanet.co.uk" 
	<viro@parcelfarce.linux.theplanet.co.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Terje Eggestad <terje.eggestad@scali.com>
In-Reply-To: <200305081009_MC3-1-37FA-2408@compuserve.com>
References: <200305081009_MC3-1-37FA-2408@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052404969.10037.42.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 May 2003 15:42:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-08 at 15:08, Chuck Ebbert wrote:
>   How would I do this on Linux?  How would virus detection and HSM
> coexist?  (HSM would have to be 'above' the virus detector, since it
> makes no sense to try and scan a file that's been migrated until it
> gets recalled back to disk.)


Userspace
	--- ptrace
VFS
	Loadable file system module (which can be made to stack stuff)
Block Layer
	Loadable disk driver (Which can be made to stack)
Disk


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbTCXXty>; Mon, 24 Mar 2003 18:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbTCXXty>; Mon, 24 Mar 2003 18:49:54 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:42416
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261224AbTCXXtv>; Mon, 24 Mar 2003 18:49:51 -0500
Subject: Re: SNARE and Ptrace?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030324222027.GD683@rdlg.net>
References: <20030324222027.GD683@rdlg.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048554843.26962.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 25 Mar 2003 01:14:03 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-24 at 22:20, Robert L. Harris wrote:
> Has anyone tested to see if "Snare" from intersectalliance.com can
> detect someone executing a ptrace attack?  An old company I used to work
> for has a number of production kernels out and can't just upgrade them
> all over night so they need a good detection method and short-term fix
> if possible.  In the past we had evaluated Snare which I pointed him to
> but we're not sure if/how it might detect such an attack.

Snare won't really help you. In fact older snare tends to make a box
less secure. The rework looked good but I've not had time to do a
detailed review and I believe they've been busy working on other
projects too.

If there is no UML or debugging done on the box, stick "return -EPERM"
at the start of sys_ptrace and just disable the entire debug/strace
feature set.



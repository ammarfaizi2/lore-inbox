Return-Path: <linux-kernel-owner+w=401wt.eu-S1754804AbWLSHID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754804AbWLSHID (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 02:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754797AbWLSHIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 02:08:02 -0500
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:44865 "EHLO
	liaag1ab.mx.compuserve.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754811AbWLSHIA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 02:08:00 -0500
Date: Tue, 19 Dec 2006 02:02:16 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [linux-cifs-client] Re: 2.6.19.1 bug? tar: file changed
  as we read it
To: "idra@samba.org" <idra@samba.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-cifs-client <linux-cifs-client@lists.samba.org>,
       Steve French <sfrench@samba.org>, Avi Kivity <avi@argo.co.il>
Message-ID: <200612190205_MC3-1-D591-6D92@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <1166458956.30152.18.camel@localhost.localdomain>

On Mon, 18 Dec 2006 11:22:36 -0500, simo wrote:

> > With cifs, a directory search shows different sizes but opening
> > them by name gives identical contents:
> > 
> > $ ll ipt_dscp* ipt_DSCP*
> > -r-------- 1 me me 1581 Jan 28  2004 ipt_dscp.c
> > -r-------- 1 me me 2753 Jan 29  2004 ipt_DSCP.c
> > $ ll ipt_dscp.c ipt_DSCP.c
> > -r-------- 1 me me 1581 Jan 28  2004 ipt_dscp.c
> > -r-------- 1 me me 1581 Jan 28  2004 ipt_DSCP.c
> > $ diff ipt_dscp.c ipt_DSCP.c
> > $
> > 
> > So where is the bug? On the server?
> 
> What is the server?
> Samba? Which vertsion?

Samba 2.2.3.

> Do you use unix extensions? Or "case sensitive = yes" ?

No UNIX extensions.  Not case sensitive.

SO this is kind of expected, but smbfs and cifs client for Linux have
subtly different behavior.

-- 
MBTI: IXTP

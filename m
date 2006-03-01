Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWCASAH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWCASAH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 13:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWCASAH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 13:00:07 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:41769 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1030221AbWCASAF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 13:00:05 -0500
Date: Wed, 1 Mar 2006 09:59:22 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: John Rose <johnrose@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] move eeh_add_device_tree_late()
Message-ID: <20060301175922.GX20175@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20060301001909.GU20175@ca-server1.us.oracle.com> <20060301010249.GV20175@ca-server1.us.oracle.com> <1141230954.19095.19.camel@sinatra.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1141230954.19095.19.camel@sinatra.austin.ibm.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2006 at 10:35:55AM -0600, John Rose wrote:
> Good catch, Mark.
Heh, thanks.

> Commit 827c1a6c1a5dcb2902fecfb648f9af6a532934eb introduced a new
> function that calls eeh_add_device_late() implicitly.  This patch
> reorders the two functions in question to fix the compile error.  This
> might be preferable to exposing eeh_add_device_late() in eeh.h.
Hmm, you still left the EXPORT_SYMBOL(eeh_add_device_late) and you didn't
make eeh_add_device_late() static. Shouldn't you do that if you don't want
to make it accessible outside of eeh.c?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264161AbUDGTQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbUDGTQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:16:24 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1785 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264161AbUDGTQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:16:23 -0400
Subject: Re: cp fails in this symlink case, kernel 2.4.25, reiserfs + ext2
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Martin Rode <martin.rode@zeroscale.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1081359310.1212.537.camel@marge.pf-berlin.de>
References: <1081359310.1212.537.camel@marge.pf-berlin.de>
Content-Type: text/plain
Message-Id: <1081365374.11164.24.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 07 Apr 2004 14:16:15 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-04-07 at 12:35, Martin Rode wrote:
> 5) cp fails
> apu:/home/martin/tmp/bug# (cd alpha/beta; cp ../latest/myfile .)
> cp: cannot stat `../latest/myfile': No such file or directory

When you cd to alpha/beta, your current directory is really
.../tmp/bug/beta.  Your shell may remember that you got there through
the symlink in alpha, but cp will follow .., which is really bug.

-- 
David Kleikamp
IBM Linux Technology Center


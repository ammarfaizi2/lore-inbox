Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVBGWyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVBGWyK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbVBGWwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:52:39 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:8103 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261326AbVBGWvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:51:01 -0500
Date: Mon, 7 Feb 2005 16:50:56 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Lorenzo Hern?ndez Garc?a-Hierro <lorenzo@gnu.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "linux-security-module@wirex.com" <linux-security-module@wirex.com>
Subject: Re: [PATCH] sys_chroot() hook for additional chroot() jails enforcing
Message-ID: <20050207225056.GA2388@IBM-BWN8ZTBWA01.austin.ibm.com>
References: <1107814610.3754.260.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1107814610.3754.260.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I understood you correct earlier, the only policy you needed to
enforce was to prevent double-chrooting.  If that is the case, why is it
not sufficient to keep a "process-has-used-chroot" flag in
current->security which is set on the first call to
capable(CAP_SYS_CHROOT) and inherited by forked children, after which
calls to capable(CAP_SYS_CHROOT) are refused?

Of course if you need to do more, then a hook might be necessary.

-serge


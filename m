Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270644AbTGUSvi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 14:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270648AbTGUSvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 14:51:38 -0400
Received: from smtp.terra.es ([213.4.129.129]:61149 "EHLO tfsmtp1.mail.isp")
	by vger.kernel.org with ESMTP id S270644AbTGUSvh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 14:51:37 -0400
From: RAMON_GARCIA_F <RAMON_GARCIA_F@terra.es>
To: Jan Harkes <jaharkes@cs.cmu.edu>, linux-kernel@vger.kernel.org
Message-ID: <6bda56825e.6825e6bda5@teleline.es>
Date: Mon, 21 Jul 2003 21:06:37 +0200
X-Mailer: Netscape Webmail
MIME-Version: 1.0
Content-Language: es
Subject: Re: Suggestion for a new system call: convert file handle to a
 cookie for transfering file handles between processes.)
X-Accept-Language: es
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I do not understand the first argument. You seem to say it is posible
to create tcpsockets between different computers while it is not useful
to pass cookies under it. I do not see any problem. Just use cookies in
the local system only.

With regard to resource limits, the solution is not too difficult. As
far as resource limits are concernted, a cookie created and not yet
destroyed should count as a file handle owned by the process and user
that created it. That is, a process cannot have more coookies opened and
 not yet consumed plus total open files than the maximum number of
process descriptors. The same for each user id. There is no need for a
new limit.

Apart from the inconvenience of sendmsg being a library function rather
than a system call, I am convinced that it would be posible to implement
unix socket descriptor passing as a library call. This is not posible
for practical reasons of backward compatibility. But that does not
demonstrate that the proposed primitive is not simpler.

Ramon



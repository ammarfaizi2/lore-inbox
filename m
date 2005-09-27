Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVI0HJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVI0HJh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVI0HJh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:09:37 -0400
Received: from web8409.mail.in.yahoo.com ([202.43.219.157]:40342 "HELO
	web8409.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S964836AbVI0HJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:09:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=LpUrD6JwNKfDl6Om1EaSqGDGgyWWMXGiup7nBg+uDNZSyRtxhrGccjzigveh1YQgUJaPn+m3/Hh0G8dPgnww1JxwV+gGeh4hspfvwwk3JX0N88ShQgpjhGkpLh+9WTWFxh8PFI1X6edLUXmq9sV8V7pgxBgbd0oaFSqqhWSTRDE=  ;
Message-ID: <20050927070933.77908.qmail@web8409.mail.in.yahoo.com>
Date: Tue, 27 Sep 2005 08:09:33 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127745249.2069.30.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


HI Sebastien,
Thanks for your Reply 
...

As i told you that i am trying to build libposix
package for arm platform,with bare Kernel AIO Support
(without applying patches) and libposix-0.6 package.

When i tried to build the package then while
configuration it is  showing Following

Error:

"Checking for default value for max events...
configure: error: cannot 
run
test program while cross compiling
See `config.log' for more details."

I traced the configure script for following Error and
got following code that is, I think causing this
Problem:

Code in configure script:

if test "${enable_default_maxevents+set}" = set; then
  enableval="$enable_default_maxevents"
  ac_aio_default_maxevents=$enableval
else
  echo "$as_me:$LINENO: checking for default value for
max events" >&5
echo $ECHO_N "checking for default value for max
events... $ECHO_C" >&6
if test "$cross_compiling" = yes; then
  { { echo "$as_me:$LINENO: error: cannot run test
program while cross
compiling
See \`config.log' for more details." >&5
echo "$as_me: error: cannot run test program while
cross compiling
See \`config.log' for more details." >&2;}
   { (exit 1); exit 1; }; }
else
  cat >conftest.$ac_ext <<_ACEOF

Even on x86 it is going into else part but their as
cross compiling is false in that case it goes to 
cat > conftest.$ac_ext <<_ACEOF


So With this code while cross compiling we always face
the same  problem...

So Can you please tell me how to resolve this
problem...

Thanks in advance...

Vikas



		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com

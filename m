Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbWETGoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbWETGoD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 02:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbWETGoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 02:44:03 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:15621 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751226AbWETGoC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 02:44:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S2D5T2Vq8PJyH5lWVoty3zuguhZPv+KeDggE801GvJpVMqSNrijtIpI/cFlKg1dE6oczQVjWtJBOkfz8zZO+xq+a8flFilNRnKBejfr2SFLLEszOIE5FLoo3Vm3CICtbcBfXBbdCkTBNm3GsUTF1cHcZsEpCAyPa8MQTnFd4Ijc=
Message-ID: <a36005b50605192344g1ba5091eq92c43d7cb52eb69d@mail.gmail.com>
Date: Fri, 19 May 2006 23:44:01 -0700
From: "Ulrich Drepper" <drepper@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] 2-ptrace_multi
Cc: "Daniel Jacobowitz" <dan@debian.org>, "Renzo Davoli" <renzo@cs.unibo.it>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       viro@ftp.linux.org.uk
In-Reply-To: <200605192217.30518.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060518155337.GA17498@cs.unibo.it>
	 <20060519174534.GA22346@cs.unibo.it>
	 <20060519201509.GA13477@nevyn.them.org>
	 <200605192217.30518.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/06, Andi Kleen <ak@suse.de> wrote:
> Alan hacked on this iirc so he might comment.

Al Viro has a similar patch in the FC kernels to govern read access to
/proc/*/maps based on the ptrace permissions.  This is probably the
same problem.  If you can use ptrace on the target process there is no
security reason why /proc/*/mem access shouldn't be granted.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWHTQFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWHTQFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWHTQFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:05:40 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:50550 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750835AbWHTQFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:05:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=neEp2JJLjZh59k1YV/ah45n+DsfJDxqpCtZ63JeKks5oSFj3FYQhinvgi1pVOB5LGFBWrd5YLtDV5+Trcr4LddtADDygIX2IERGmiUANq1dlQ94437hHaXeC5+lIy1y6lXth+L26fd+Gq6hmEYZpQVKu/G+wchXo6Kn+/m4PLac=
Message-ID: <18d709710608200905j37ba1cb3vbb027fea88801c5c@mail.gmail.com>
Date: Sun, 20 Aug 2006 13:05:39 -0300
From: "Julio Auto" <mindvortex@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: On the definition of the module_param_string macro
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.6.17.9, the definition of the module_param_string macro
receives 4 parameters (see linux/include/linux/moduleparam.h:87):

#define module_param_string(name, string, len, perm) ...

allowing the name of the parameter (fed to the macro as 'name'), as it
will be in the .modinfo section, to be different from the actual name
of the variable (fed to the macro as 'string').
To me, it looks inconsistent. If, on the other hand, it was supposed
to be a 'feature', the it looks plain useless (otherwise, the same
rule should apply to other module_param* macros).
So, I would suggest that the definition changes to:

#define module_param_string(name, len, perm) ...

where it would behave like a current use of 'module_param_string(name,
name, len, perm);'

I understand that such changes in the API of modules may cause some
trouble, but it doesn't cost a thing to look at this one as a possible
improvement for the future.

Cheers,

    Julio Auto

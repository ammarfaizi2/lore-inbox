Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964808AbWGEQck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964808AbWGEQck (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 12:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWGEQcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 12:32:39 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:16138 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964808AbWGEQcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 12:32:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J6qEMBRttOe3a/TKPoi0QVirnrQckCFqNmgsk2dwE3wrMJY99lYQA60aG6ZI30KeG6tBL7aA2sdHOOn6rIc7y3ho6vlSvB+/1lci6E50e2UIuWcyZPHhIHPf6YpYJx8Ez0TyLZLfR2MylFy1UrLjwJ6Tdux/1lEKaGQUTugJZYc=
Message-ID: <e1e1d5f40607050932v2441aa0chd8a2aac31e0b6881@mail.gmail.com>
Date: Wed, 5 Jul 2006 12:32:38 -0400
From: "Daniel Bonekeeper" <thehazard@gmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I said before, usefulness is something relative, and sometimes,
security is not a concern (even when talking about fingerprint
readers).
My intention with this is to try to create a catalog of fingerprint
readers' properties and I think that taking a look at vendors' SDKs
would be a good start.
As pointed out by Greg, it would be also interesting to export those
properties via sysfs instead of structure passing (or in addiction,
not sure yet).
I'm not sure though about relating fingerprint devices with V4L2 (even
the cheapest ones). Some other considerations discussed with Greg are
also:

1) extending those device informations to other classes, not only to
fingerprint readers
2) maybe using another layer to hold device properties based on
classes ( device driver -> device information layer -> sysfs+kobjects
) so we can have specific properties for "fingerprintreader" objects
and easier ways to export them to the sysfs layer, without explicit
declaration on the device driver
3) extend that layer also to non-USB devices ( bus-independent )

Maybe sysfs classes could have a list of default properties (for
example, /sys/class/fingerprint objects could hold a list of commom
fingerprint properties).

Bill, which fingerprint reader are you using ?

Daniel

-- 
What this world needs is a good five-dollar plasma weapon.
